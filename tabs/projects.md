---
layout: page
title: Projects
---

**Under construction ;)**

### My repositories:
{% assign self_repo = site.github.username | append: ".github.io" %}
{% for repository in site.github.public_repositories %}
  {% if repository.name == self_repo %}
    (skipping self)
  {% else %}
* [{{ repository.name }}]({{ repository.html_url }} "{{ repository.project_title }}"):  
&nbsp;&nbsp;&nbsp;&nbsp;{{ repository.project_tagline }}
  {% endif %}
{% else %}
*Oups! Looks like something went wrong!*
{% endfor %}

