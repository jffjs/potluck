class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  before_save :take_apart

  def name
    self.ingredient.name
  end

  private

  # This works pretty well so far, but needs a bit more work.
  # What if measurement is missing? ie. '2 eggs'
  def take_apart
    amount_regex = /(\d+(?! *\/))? *-? *(?:(\d+) *\/ *(\d+))?/
    base = self.raw.strip
    match = base.match(amount_regex)
    if match
      self.amount = match.to_s.strip
      measure_and_rest = match.post_match
      next_match = measure_and_rest.match(/\w+/)
      if next_match
        self.measurement = next_match.to_s
        rest = strip_first_preposition(next_match.post_match.strip.downcase)
        ing = Ingredient.first(conditions: { name: rest }) ||
              Ingredient.create(name: rest)
        self.ingredient_id = ing.id
      end
    end
  end

  def strip_first_preposition(text)
    preps = [/^of/]
    preps.each do |prep|
      text = text.gsub(prep, '').strip
    end
    text
  end
end
