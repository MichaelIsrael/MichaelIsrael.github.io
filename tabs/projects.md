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
    - {{ repository.project_tagline }}
    - {{ repository.project_title }}
  {% endif %}
{% else %}
*Oups! Looks like something went wrong!*
{% endfor %}

