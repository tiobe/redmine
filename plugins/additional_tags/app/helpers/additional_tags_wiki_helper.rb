# frozen_string_literal: true

module AdditionalTagsWikiHelper
  def sidebar_tags
    unless @sidebar_tags
      @sidebar_tags = []
      @sidebar_tags = WikiPage.available_tags project: @project if AdditionalTags.show_sidebar_tags?
    end
    @sidebar_tags
  end

  def render_sidebar_tags
    options = { show_count: AdditionalTags.setting?(:show_with_count),
                style: AdditionalTags.setting(:tags_sidebar).to_sym,
                link_wiki_tag: true,
                project: @project }

    render_tags_list sidebar_tags, **options
  end

  def render_wiki_index_title(project: nil, name: nil, tag: nil, title: :label_wiki)
    if tag.present?
      if project
        t :label_wiki_index_for_tag_html, tag: tag
      else
        title = [link_to(l(title), wiki_index_path)]
        title << Additionals::LIST_SEPARATOR
        title << t(:label_wiki_index_for_tag_html, tag: tag)
        safe_join title, ' '
      end
    elsif name.present?
      title = [link_to(l(title), wiki_index_path)]
      title << Additionals::LIST_SEPARATOR
      title << name
      safe_join title, ' '
    else
      l title
    end
  end
end
