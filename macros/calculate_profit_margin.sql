{% macro calculate_profit_margin(price, cost) %}
    case 
        when {{ price }} > 0 then round(({{ price }} - {{ cost }}) / {{ price }} * 100, 2)
        else 0
    end
{% endmacro %}