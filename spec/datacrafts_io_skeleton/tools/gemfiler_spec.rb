# frozen_string_literal: true

RSpec.describe DatacraftsIoSkeleton::Tools::Gemfiler do
  after do
    described_class.clean!
  end

  describe ".add" do
    it "raises error when gem is added to an unsupported group" do
      expect { described_class.add("rubocop", group: :acdc) }.to raise_error("Gem group acdc is not supported")
    end
  end

  describe ".render" do
    let(:group) { :common }
    let(:required) { true }
    subject(:render) { described_class.render(group) }

    before do
      described_class.add("rspec", group: group, required: required)
    end

    context "when gem with required (true) option is added" do
      it "renders gem without required option since it's default value" do
        is_expected.to eq "gem 'rspec'"
      end
    end

    context "when gem with required (false) option is added" do
      let(:required) { false }

      it "renders gem with required false parameter" do
        is_expected.to eq "gem 'rspec', require: false"
      end
    end
  end
end
