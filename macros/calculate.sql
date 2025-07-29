{% macro calculate(column1, column2) -%}
    {{ column1 }} + {{ column2 }}
{%- endmacro %}
