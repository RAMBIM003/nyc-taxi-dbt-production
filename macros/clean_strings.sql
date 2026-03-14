{% macro clean_string(column_name) %}
    
    trim(initcap({{ column_name }}))
{% endmacro %}