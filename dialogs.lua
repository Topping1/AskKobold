local InputDialog = require("ui/widget/inputdialog")
local ChatGPTViewer = require("chatgptviewer")
local UIManager = require("ui/uimanager")
local _ = require("gettext")

local queryChatGPT = require("gpt_query")

local function showChatGPTDialog(ui, highlightedText)
  local title = ui.document:getProps().title or _("Unknown Title")
  local author = ui.document:getProps().authors or _("Unknown Author")

  local input_dialog
  input_dialog = InputDialog:new {
    title = _("Ask a question about the highlighted text"),
    input_hint = _("Type your question here..."),
    input_type = "text",
    buttons = {
      {
        {
          text = _("Cancel"),
          callback = function()
            UIManager:close(input_dialog)
          end,
        },
        {
          text = _("Ask"),
          callback = function()
            local InfoMessage = require("ui/widget/infomessage")
            local loading = InfoMessage:new {
              text = _("Loading..."),
              timeout = 1,
            }
            UIManager:show(loading)

            -- Construct the prompt
            local context = "I'm reading something titled '" .. title .. "' by " .. author ..
                            ". I have a question about the following highlighted text: " .. highlightedText
            local question = input_dialog:getInputText()
            local prompt = context .. "\n\nUser: " .. question

            -- Query ChatGPT
            local answer = queryChatGPT(prompt)

            UIManager:close(loading)
            UIManager:close(input_dialog)

            -- Create the result text
            local result_text = _("Highlighted text: ") .. "\"" .. highlightedText .. "\"" ..
                                "\n\n" .. _("User: ") .. question ..
                                "\n\n" .. _("ChatGPT: ") .. answer

            -- Function to handle new questions
            local function handleNewQuestion(chatgpt_viewer, new_question)
              local new_prompt = context .. "\n\nUser: " .. new_question
              local new_answer = queryChatGPT(new_prompt)
              result_text = result_text .. "\n\n" .. _("User: ") .. new_question ..
                            "\n\n" .. _("ChatGPT: ") .. new_answer
              chatgpt_viewer:update(result_text)
            end

            -- Show the viewer with the result
            local chatgpt_viewer = ChatGPTViewer:new {
              title = _("AskKoboldCpp"),
              text = result_text,
              onAskQuestion = handleNewQuestion,
            }

            UIManager:show(chatgpt_viewer)
          end,
        },
      },
    },
  }
  UIManager:show(input_dialog)
  input_dialog:onShowKeyboard()
end

return showChatGPTDialog