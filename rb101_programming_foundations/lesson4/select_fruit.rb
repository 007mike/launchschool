produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}


def select_fruit(produce_list)

  fruits = produce_list.select do |key, value|
    value == 'Fruit'
  end

  fruits
end

p select_fruit(produce)