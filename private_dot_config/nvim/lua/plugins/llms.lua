return {
    {
        "David-Kunz/gen.nvim",
        config = function()
            local gen = require("gen")

            gen.model = "mistral:instruct"
            gen.prompts["Prompt"] = {
                prompt = "$input",
                replace = false
            }
        end
    }
}
