---
layout: tocpage
# layout: projects
title: Projects
toc: true
# © 2020 Michael Israel
---

## My repositories
{% assign self = site.github.username | append: ".github.io" %}
{% for repository in site.github.public_repositories %}
  {% unless repository.name == self %}
### {{ repository.name }}
    {% unless repository.description == "" or repository.description == nil %}
<font size="2">{{ repository.description }}</font>
    {% endunless %}
* Github: <a href="{{ repository.html_url }}">{{ repository.full_name }}</a>
    {% unless repository.homepage == "" or repository.homepage == nil %}
* Homepage: <a href="{{ repository.homepage }}">{{ repository.homepage }}</a>
    {% endunless %}
    {% unless repository.language == "" or repository.language == nil %}
* Language: {{ repository.language }}
    {% endunless %}
    {% unless repository.pushed_at == "" or repository.pushed_at == nil %}
* Last push: {{ repository.pushed_at }}
    {% endunless %}
    {% unless repository.license == "" or repository.license == nil %}
* License: <a href="{{ repository.license.url }}">{{ repository.license.name }}</a>
    {% endunless %}

    {% comment %}
      {% for key_val in repository %}
        - {{ key_val[0] }}: {{key_val[1]}}
      {% endfor %}
    {% endcomment %}
  {% endunless %}
{% else %}
*Oups! Looks like something went wrong!*
{% endfor %}

