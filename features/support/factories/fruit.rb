FactoryGirl.define do
  factory :fruit do
    sequence(:name) { |n| FRUITS[n-1] }
  end
end

FRUITS = ['Apple', 'Apricot', 'Banana', 'Bilberry', 'Blackberry', 'Blackcurrant', 'Blueberry', 'Boysenberry',
          'Cantaloupe', 'Currant', 'Cherry', 'Cherimoya', 'Cloudberry', 'Coconut', 'Cranberry', 'Damson', 'Date',
          'Dragonfruit', 'Durian', 'Elderberry', 'Feijoa', 'Fig', 'Goji berry', 'Gooseberry', 'Grape', 'Raisin',
          'Grapefruit', 'Guava', 'Huckleberry', 'Jackfruit', 'Jambul', 'Jujube', 'Kiwi fruit', 'Kumquat', 'Lemon',
          'Lime', 'Loquat', 'Lychee', 'Mango', 'Marion berry', 'Melon', 'Cantaloupe', 'Honeydew', 'Watermelon',
          'Rock melon', 'Miracle fruit', 'Mulberry', 'Nectarine', 'Olive', 'Orange', 'Clementine', 'Mandarine',
          'Tangerine', 'Papaya', 'Passionfruit', 'Peach', 'Pear', 'Williams pear', 'Bartlett pear', 'Persimmon',
          'Physalis', 'Plum/prune (dried plum)', 'Pineapple', 'Pomegranate', 'Pomelo', 'Purple Mangosteen', 'Quince',
          'Raspberry', 'Salmon berry', 'Black raspberry', 'Rambutan', 'Redcurrant', 'Salal berry', 'Satsuma',
          'Star fruit', 'Strawberry', 'Tamarillo', 'Ugli fruit']