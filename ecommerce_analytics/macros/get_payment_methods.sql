{% macro get_payment_methods() %}
    {{ return(['credit_card', 'debit_card', 'paypal', 'apple_pay', 'google_pay']) }}
{% endmacro %}