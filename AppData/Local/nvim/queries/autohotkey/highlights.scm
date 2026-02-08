; ===== Basic highlights =====

; Identifiers
(identifier) @variable

; Comments
(comment) @comment
(block_comment) @comment
(doc_comment) @comment

; Strings
(string) @string
(continuation_section) @string
(escape_sequence) @string.escape

; Numbers
(number) @number

; Keywords
(keyword) @keyword
(parameter_modifier) @keyword
(new_expression "new" @keyword)
(return_statement) @keyword
(if_statement) @keyword
(else_clause) @keyword
(while_statement) @keyword
(loop_statement) @keyword
(loop_statement "," @punctuation.delimiter)
(loop_type) @keyword
(for_statement) @keyword
(try_statement) @keyword
(catch_clause) @keyword
(catch_clause exception: (identifier) @variable.parameter)
(finally_clause) @keyword

; Switch statements
(switch_statement) @keyword
(switch_statement "{" @punctuation.bracket)
(switch_statement "}" @punctuation.bracket)
(case_clause) @keyword
(case_clause ":" @punctuation.delimiter)
(default_clause) @keyword
(default_clause ":" @punctuation.delimiter)

; Statement blocks
(statement_block "{" @punctuation.bracket)
(statement_block "}" @punctuation.bracket)

; Parentheses
(parenthesized_expression "(" @punctuation.bracket)
(parenthesized_expression ")" @punctuation.bracket)

; Operators
(operator) @operator
(assignment_expression ":=" @operator)
(assignment_expression "+=" @operator)
(assignment_expression "-=" @operator)
(assignment_expression "*=" @operator)
(assignment_expression "/=" @operator)
(assignment_expression ".=" @operator)
(binary_expression "||" @operator)
(binary_expression "&&" @operator)
(binary_expression "|" @operator)
(binary_expression "^" @operator)
(binary_expression "&" @operator)
(binary_expression "<<" @operator)
(binary_expression ">>" @operator)
(binary_expression "=" @operator)
(binary_expression "==" @operator)
(binary_expression "!=" @operator)
(binary_expression "<>" @operator)
(binary_expression "<" @operator)
(binary_expression ">" @operator)
(binary_expression "<=" @operator)
(binary_expression ">=" @operator)
(binary_expression "+" @operator)
(binary_expression "-" @operator)
(binary_expression "*" @operator)
(binary_expression "/" @operator)
(binary_expression "//" @operator)
(binary_expression "%" @operator)
(binary_expression "**" @operator)
(binary_expression "." @operator)
(unary_expression "!" @operator)
(unary_expression "~" @operator)
(unary_expression "-" @operator)
(ternary_expression "?" @operator)
(ternary_expression ":" @operator)
(force_expr_start) @operator

; Hotkeys and Hotstrings
(hotkey) @keyword
(hotstring_definition ":" @punctuation.delimiter)
(hotstring_definition "::" @punctuation.delimiter)
(hotstring_trigger) @string.special
(hotstring_options) @attribute
(hotstring_replacement) @string

; Directives
(directive) @attribute
(directive name: (identifier) @attribute)
(directive_arguments) @string.special
(if_directive) @attribute
(if_win_directive) @attribute
(if_win_directive (if_win_type) @attribute)
(if_win_directive (if_win_title) @string.special)
(if_win_directive (if_win_title (string) @string))
(if_win_directive (if_win_text) @string.special)

; Functions
(function_definition name: (identifier) @function)
(function_call name: (identifier) @function)
(method_call method: (identifier) @function.method)

; Member expressions and types
(member_expression property: (identifier) @property)
(method_call object: (identifier) @type)
(member_expression object: (identifier) @type)
(new_expression class: (identifier) @type)
(new_expression class: (member_expression property: (identifier) @type))
(command name: (identifier) @function)
(if_command name: (identifier) @function)

; Built-in commands (case-sensitive, with lowercase duplicates)
((command name: (identifier) @function.builtin)
 (#match? @function.builtin "^(MsgBox|InputBox|ToolTip|TrayTip|Progress|Gui|GuiControl|GuiControlGet|Menu)$"))
((command name: (identifier) @function.builtin)
 (#match? @function.builtin "^(msgbox|inputbox|tooltip|traytip|progress|gui|guicontrol|guicontrolget|menu)$"))

; Keywords in commands
((identifier) @keyword
 (#match? @keyword "^(Reload|Exit|ExitApp|Pause|Suspend|Critical|Thread)$"))
((command name: (identifier) @keyword)
 (#match? @keyword "^(Goto|Gosub)$"))

; Special variables
((identifier) @variable.special
 (#match? @variable.special "^(A_ScriptDir|A_ScriptName|A_ScriptFullPath|A_ScriptHwnd|WorkingDir|ThisFunc|ThisLabel)$"))
((identifier) @constant.builtin
 (#match? @constant.builtin "^(ahk_id|ahk_class|ahk_exe|ahk_pid|ahk_group)$"))

; Labels
(label . (identifier) @label)

; GUI
(gui_action gui_name: (identifier) @string.special)
(gui_target gui_name: (identifier) @string.special)
(gui_options gui_name: (identifier) @string.special)
(gui_options option: (gui_option_flag) @constant)
(gui_option_flag) @constant
(gui_action_spaced gui_name: (identifier) @string.special)
((gui_action_spaced action: (identifier) @function.builtin)
 (#match? @function.builtin "^(Add|Show|Submit|Cancel|Hide|Destroy|Font|Color|Margin|Menu|Minimize|Maximize|Restore|Flash|Default|New|Options)$"))

; Arrays and objects
(array_literal "[" @punctuation.bracket)
(array_literal "]" @punctuation.bracket)
(index_expression "[" @punctuation.bracket)
(index_expression "]" @punctuation.bracket)
(object_literal "{" @punctuation.bracket)
(object_literal "}" @punctuation.bracket)
(object_property key: (identifier) @property)
(object_property key: (string) @property)
(object_property key: (number) @property)

; Classes
(class_definition) @keyword
(class_definition name: (identifier) @type)
(class_definition parent: (identifier) @type)
(class_definition "{" @punctuation.bracket)
(class_definition "}" @punctuation.bracket)
(method_definition) @keyword
(method_definition name: (identifier) @function.method)
(method_definition
  name: (identifier) @function.special
  (#match? @function.special "^(New|Delete|Get|Set|Call)$"))
(class_property) @keyword
(class_property name: (identifier) @property)
(this_expression) @variable.special
(base_expression) @variable.special
