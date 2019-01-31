class ColorizeController < ApplicationController
  def colorize
    input = {
      image: params.fetch("image_url").strip
    }

    # ================================================================================
    # Your code goes below.
    # ================================================================================

    client = Algorithmia.client('simDcI/TGD/g9KX7ucQQlxzYMGF1')
    algo = client.algo('deeplearning/ColorfulImageColorization/1.1.13')
    result = algo.pipe(input).result
    unformatted_url = result.dig("output")
    formatted_url = unformatted_url.gsub! 'data://', 'https://algorithmia.com/v1/data/'
    
    @original_image_url = params.fetch("image_url").strip
    @colorized_image_url = formatted_url

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("colorize_templates/colorize.html.erb")
  end

  def colorize_form
    render("colorize_templates/colorize_form.html.erb")
  end
end
