IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:HISTORY_FILE] = "log/.irb_history"

IRB.conf[:PROMPT][:MY_PROMPT] = {
  :PROMPT_I => "» ",          # 通常時のプロンプト
  :PROMPT_N => "╎ ",          # 継続行のプロンプト
  :PROMPT_S => "╎ ",          # 文字列などの継続行のプロンプト
  :PROMPT_C => "╎ ",          # 式が継続している時のプロンプト
  :RETURN => "#>%s\n"   # メソッドから戻る時のプロンプト
}

IRB.conf[:PROMPT_MODE] = :MY_PROMPT
IRB.conf[:USE_AUTOCOMPLETE] = false
