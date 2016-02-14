# tier limits, in returning users/month
T1_LIMIT = 1000
T2_LIMIT = 10000    # 10K
T3_LIMIT = 100000   # 100K
T4_LIMIT = 1000000  # 1M
T5_LIMIT = 10000000 # 10M

# prices for tiers
T1_PRICE = 0
T2_PRICE = 500
T3_PRICE = 1500
T4_PRICE = 8000
T5_PRICE = 50000

# slider range
SLIDER_MIN = 0
SLIDER_MAX = T5_LIMIT


calculate_cost = (user_count) ->
  cost = if user_count < T1_LIMIT
    T1_PRICE
  else if user_count <= T2_LIMIT
    user_count * T2_PRICE / T2_LIMIT
  else if user_count <= T3_LIMIT
    T2_PRICE + (user_count - T2_LIMIT) * (T3_PRICE - T2_PRICE) / (T3_LIMIT - T2_LIMIT)
  else if user_count <= T4_LIMIT
    T3_PRICE + (user_count - T3_LIMIT) * (T4_PRICE - T3_PRICE) / (T4_LIMIT - T3_LIMIT)
  else if user_count <= T5_LIMIT
    T4_PRICE + (user_count - T4_LIMIT) * (T5_PRICE - T4_PRICE) / (T5_LIMIT - T4_LIMIT)

  Math.ceil cost


$ ->
  slider = new Slider '#pricing_slider',
    tooltip: 'hide'
    scale: 'logarithmic'
    min: SLIDER_MIN
    max: SLIDER_MAX
    step: 1
    value: 0

  user_count_el = $ '#pricing_slider_user_count'
  cost_el = $ '#pricing_slider_cost'

  slider.on 'change', (counts) ->
    user_count_el.text counts.newValue.toLocaleString()
    cost_el.text calculate_cost(counts.newValue).toLocaleString()