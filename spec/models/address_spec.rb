require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'Table' do
    describe 'Translations' do
      it 'has table name singular translation' do
        expect(I18n.exists?('activerecord.models.address.one')).to be_truthy, 'Column translation missing: Address(:one)'
      end

      it 'has table name plural translation' do
        expect(I18n.exists?('activerecord.models.address.other')).to be_truthy, 'Column translation missing: Address(:other)'
      end
    end

    describe '#person_id' do
      it 'has database column' do
        expect(subject).to have_db_column(:person_id)
      end

      it 'has belongs_to relation' do
        expect(subject).to belong_to(:person)
                             .class_name('::Person')
                             .inverse_of(:addresses)
                             .with_foreign_key(:person_id)
      end

      it 'has index' do
        expect(subject).to have_db_index(:person_id)
      end

      it 'has translation' do
        expect(I18n.t('activerecord.attributes.address.person_id')).to eq('Pessoa')
      end
    end

    describe '#street' do
      it 'has database column' do
        expect(subject).to have_db_column(:street).of_type(:string).with_options(null: false)
      end

      it 'has translation' do
        expect(described_class.human_attribute_name('street')).to eq 'Rua'
      end

      it { is_expected.to validate_presence_of(:street) }
    end

    describe '#city' do
      it 'has database column' do
        expect(subject).to have_db_column(:city).of_type(:string).with_options(null: false)
      end

      it 'has translation' do
        expect(described_class.human_attribute_name('city')).to eq 'Cidade'
      end

      it { is_expected.to validate_presence_of(:city) }
    end

    describe '#state' do
      it 'has database column' do
        expect(subject).to have_db_column(:state).of_type(:string).with_options(null: false)
      end

      it 'has translation' do
        expect(described_class.human_attribute_name('state')).to eq 'Estado'
      end

      it { is_expected.to validate_presence_of(:state) }
    end

    describe '#country' do
      it 'has database column' do
        expect(subject).to have_db_column(:country).of_type(:string).with_options(null: false)
      end

      it 'has translation' do
        expect(described_class.human_attribute_name('country')).to eq 'País'
      end

      it { is_expected.to validate_presence_of(:country) }
    end

    describe '#postal_code' do
      it 'has database column' do
        expect(subject).to have_db_column(:postal_code).of_type(:integer).with_options(null: false)
      end

      it 'has translation' do
        expect(described_class.human_attribute_name('postal_code')).to eq 'Código postal'
      end

      it { is_expected.to validate_presence_of(:postal_code) }
    end

    describe '#uuid' do
      it 'has database column' do
        expect(subject).to have_db_column(:uuid).of_type(:uuid)
      end

      it 'has translation' do
        expect(described_class.human_attribute_name('uuid')).to eq 'UUID'
      end
    end

    describe 'Scopes' do
      describe '.by_street' do
        let!(:address) { create(:address, street: '7 de Setembro') }

        it 'must be an scope attributes' do
          expect(described_class.by_street('')).to be_an_scope_attributes
        end

        context 'when the search matches with a address street' do
          it 'must return the matching records' do
            expect(described_class.by_street('Setembro').pluck(:id)).to eq [address.id]
          end
        end

        context 'when the search does not matches with a address street' do
          it 'must return empty' do
            expect(described_class.by_street('1° de Janeiro')).to be_empty
          end
        end
      end

      describe '.by_city' do
        let!(:address) { create(:address, city: 'Blumenau') }

        it 'must be an scope attributes' do
          expect(described_class.by_city('')).to be_an_scope_attributes
        end

        context 'when the search matches with a address city' do
          it 'must return the matching records' do
            expect(described_class.by_city('Blu').pluck(:id)).to eq [address.id]
          end
        end

        context 'when the search does not matches with a address city' do
          it 'must return empty' do
            expect(described_class.by_city('Timbó')).to be_empty
          end
        end
      end

      describe '.by_state' do
        let!(:address) { create(:address, state: 'Santa Catarina') }

        it 'must be an scope attributes' do
          expect(described_class.by_state('')).to be_an_scope_attributes
        end

        context 'when the search matches with a address state' do
          it 'must return the matching records' do
            expect(described_class.by_state('Santa').pluck(:id)).to eq [address.id]
          end
        end

        context 'when the search does not matches with a address state' do
          it 'must return empty' do
            expect(described_class.by_state('São Paulo')).to be_empty
          end
        end
      end

      describe '.by_country' do
        let!(:address) { create(:address, country: 'Brasil') }

        it 'must be an scope attributes' do
          expect(described_class.by_country('')).to be_an_scope_attributes
        end

        context 'when the search matches with a address country' do
          it 'must return the matching records' do
            expect(described_class.by_country('Brasil').pluck(:id)).to eq [address.id]
          end
        end

        context 'when the search does not matches with a address country' do
          it 'must return empty' do
            expect(described_class.by_country('Argentina')).to be_empty
          end
        end
      end

      describe '.by_postal_code' do
        let!(:address) { create(:address, postal_code: 89025410) }

        it 'must be an scope attributes' do
          expect(described_class.by_postal_code('')).to be_an_scope_attributes
        end

        context 'when the search matches with a address country' do
          it 'must return the matching records' do
            expect(described_class.by_postal_code('89025410').pluck(:id)).to eq [address.id]
          end
        end

        context 'when the search does not matches with a address country' do
          it 'must return empty' do
            expect(described_class.by_postal_code('89010202')).to be_empty
          end
        end
      end
    end

    describe '.create' do
      context 'when a new record is not persisted yet' do
        let(:address) { build(:address) }

        it 'must not have a uuid' do
          expect(address.uuid).to be_nil
        end
      end

      context 'when the record is already persisted' do
        let(:address) { create(:address) }

        it 'must have a random uuid' do
          expect(address.reload.uuid).to_not be_nil
        end
      end
    end
  end
end
