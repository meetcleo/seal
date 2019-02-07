require 'spec_helper'

describe 'config/meetcleo.yml' do
  it 'is valid YAML' do
    config = YAML.load_file('config/meetcleo.yml')

    expect(config).to be_a(Hash)
  end
end
