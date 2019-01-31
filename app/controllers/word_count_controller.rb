class WordCountController < ApplicationController
  def word_count
    @text = params.fetch("user_text")
    @special_word = params.fetch("user_word")
    @text_downcase = @text.downcase
    @special_word_downcase = @special_word.downcase

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @word_count = @text.split.length

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.length - @text.scan(/(?=#{" "})/).length

    @occurrences = @text_downcase.scan(/(?=#{@special_word_downcase})/).length

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count_templates/word_count.html.erb")
  end

  def word_count_form
    render("word_count_templates/word_count_form.html.erb")
  end
end
