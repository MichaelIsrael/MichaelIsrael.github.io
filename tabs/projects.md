---
layout: page
title: Projects
---

### My repositories:
{% assign self_repo = site.github.username | append: ".github.io" %}
{% for repository in site.github.public_repositories %}
  {% if repository.name == self_repo %}
    {% comment %} skipping self {% endcomment %}
  {% else %}
* <a href="{{ repository.html_url }}">{{ repository.name }}</a>
    {% unless repository.project_tagline == "" or repository.project_tagline == nil %}
    - {{ repository.project_tagline }}
    {% endunless %}
    {% unless repository.project_title == "" or repository.project_title == nil %}
    - {{ repository.project_title }}
    {% endunless %}
  {% endif %}
{% else %}
*Oups! Looks like something went wrong!*
{% endfor %}

