FactoryGirl.define do
  factory :vegetable do
    sequence(:name) { |n| VEGETABLES[n-1] }
  end

  #factory :legume, class: Vegetable do
  #  sequence(:name) { |n| LEGUMES[n-1] }
  #end
end

VEGETABLES = ['Artichoke', 'Arugula', 'Asparagus', 'Amaranth', 'Bok choy', 'Broccoflower', 'Broccoli',
              'Brussels sprouts', 'Cabbage', 'Calabrese', 'Cannabis', 'Carrots', 'Cauliflower', 'Celery', 'Chard',
              'Collard greens', 'Corn salad', 'Eggplant', 'Endive', 'Fiddleheads', 'Frisee', 'Kale', 'Kohlrabi',
              'Lettuce Lactuca sativa', 'Corn', 'Mushrooms', 'Mustard greens', 'Nettles', 'New Zealand spinach', 'Okra',
              'Parsley', 'Radicchio', 'Rhubarb', 'Salsify', 'Skirret', 'Spinach', 'Topinambur', 'Tat soi', 'Tomato',
              'Water chestnut', 'Watercress']

LEGUMES = ['Alfalfa sprouts', 'Azuki beans', 'Bean sprouts', 'Black beans', 'Black-eyed peas', 'Borlotti bean',
           'Broad beans', 'Chickpeas', 'Green beans', 'Kidney beans', 'Lentils', 'Lima beans', 'Mung beans',
           'Navy beans', 'Pinto beans', 'Runner beans', 'Soy beans', 'Snap peas']

HERBS_AND_SPICES = ['Anise', 'Basil', 'Caraway', 'Cilantro', 'Coriander', 'Chamomile', 'Dill', 'Fennel', 'Lavender',
                    'Lemon Grass', 'Marjoram', 'Oregano', 'Parsley', 'Rosemary', 'Sage', 'Thyme']

ONIONS = ['Chives', 'Garlic', 'Leek Allium porrum', 'Onion', 'Shallot', 'Scallion']

PEPPERS = ['Bell pepper', 'Chili pepper', 'Jalapeno', 'Habanero', 'Paprika', 'Tabasco pepper', 'Cayenne pepper']

ROOT_VEGETABLES = ['Beet', 'Carrot', 'Celeriac', 'Daikon', 'Ginger', 'Parsnip', 'Rutabaga', 'Turnip']

RADISH = ['Rutabaga', 'Turnip', 'Wasabi', 'Horseradish', 'White radish']

SQUASHES = ['Acorn squash', 'Butternut squash', 'Banana squash', 'Zucchini', 'Cucumber', 'Delicata', 'Gem squash',
            'Hubbard squash', 'Squash', 'Patty pans', 'Pumpkin', 'Spaghetti squash']

TUBERS = ['Jicama', 'Jerusalem artichoke', 'Potato', 'Sweet potato', 'Taro', 'Yam']