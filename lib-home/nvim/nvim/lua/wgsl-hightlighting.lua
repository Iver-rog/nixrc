return function()
  vim.cmd [[
    highlight! link @function Function
    highlight! link @variable Identifier
    highlight! link @type Type
    highlight! link @type.builtin Type
    highlight! link @boolean Boolean
    highlight! link @number Number
    highlight! link @keyword Keyword
    highlight! link @comment Comment
    highlight! link @operator Operator
  ]]
end
