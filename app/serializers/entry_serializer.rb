class EntrySerializer < ActiveModel::Serializer
  embed :ids, include: false
  
  attributes :id,
    :date,
    :score,
    :stools,
    :ab_pain,
    :general,
    :complication_arthritis,
    :complication_iritis,
    :complication_erythema,
    :complication_fistula,
    :complication_other_fistula,
    :complication_fever,
    :opiates,
    :mass,
    :hematocrit,
    :weight_current,
    :created_at
    
    def date
      DateTime.strptime(object.date.to_s, "%s")
    end
    
end