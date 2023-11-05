return {
    {
        "David-Kunz/gen.nvim",
        config = function()
            local gen = require("gen")

            gen.model = "zephyr:7b"
            gen.prompts["Prompt"] = {
                prompt = "$input",
                replace = false
            }
        end
    }
}
