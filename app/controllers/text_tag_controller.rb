class TextTagController < ApplicationController
  def text_tag
    @text = params.fetch("text")

    # ================================================================================
    # Your code goes below.
    # ================================================================================

    input = @text
    client = Algorithmia.client('simDcI/TGD/g9KX7ucQQlxzYMGF1')
    algo = client.algo('nlp/AutoTag/1.0.1')
    result = algo.pipe(input).result
    @tags = result

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("text_tag_templates/text_tag.html.erb")
  end

  def text_tag_form
    render("text_tag_templates/text_tag_form.html.erb")
  end
end
