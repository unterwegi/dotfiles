local response_format = "Respond EXACTLY in this format:\n```$ftype\n<your code>\n```"

return {
    {
        "nomnivore/ollama.nvim",
        opts = {
            model = "zephyr:7b",
            prompts = {
                Enhance_Grammar_Spelling = {
                    prompt = "Modify the following $ftype text to improve grammar and spelling. "
                        .. response_format
                        .. "\n\n```$ftype\n$sel```",
                    action = "replace"
                },
                Enhance_Wording = {
                    prompt = "Modify the following $ftype text to use better wording. "
                        .. response_format
                        .. "\n\n```$ftype\n$sel```",
                    action = "replace"
                },
                Make_Concise = {
                    prompt = "Modify the following $ftype text to make it as simple and concise as possible. "
                        .. response_format
                        .. "\n\n```$ftype\n$sel```",
                    action = "replace"
                },
                Make_List = {
                    prompt = "Render the following $ftype text as a markdown list. "
                        .. response_format
                        .. "\n\n```$ftype\n$sel```",
                    action = "replace"
                },
                Make_Table = {
                    prompt = "Render the following $ftype text as a markdown table. "
                        .. response_format
                        .. "\n\n```$ftype\n$sel```",
                    action = "replace"
                },
                Review_Code = {
                    prompt = "Review the following $filetype code and make concise suggestions:\n```$ftype\n$sel\n```",
                    action = "display"
                },
            }
        },
    },
}
