class ConfigTable < ActiveRecord::Base
  def self.lookup(key)
    tuple = ConfigTable.find_by_key(key)

    return nil if tuple == nil
    return tuple.value
  end

  def self.set(key, value)
    tuple = ConfigTable.find_by_key(key)

    if tuple != nil
      tuple.value = value
      return tuple.save
    else
      return ConfigTable.create(key: key, value: value)
    end
  end
end
