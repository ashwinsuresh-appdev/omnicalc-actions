class ImageTagController < ApplicationController
  def image_tag
    input = {
      image: params.fetch("image_url").strip
    }

    # ================================================================================
    # Your code goes below.
    # ================================================================================

    # input = { image: "http://www.pjproductions.co.uk/blog_images/Chicago-Booth-Group-photo-Pete-Jones.jpg" }

    client = Algorithmia.client('simDcI/TGD/g9KX7ucQQlxzYMGF1')
    algo = client.algo('deeplearning/IllustrationTagger/0.4.0')
    raw_result = algo.pipe(input).result["general"]

    @original_image_url = params.fetch("image_url").strip
    @tag_hashes = raw_result

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("image_tag_templates/image_tag.html.erb")
  end

  def image_tag_form
    render("image_tag_templates/image_tag_form.html.erb")
  end
end
