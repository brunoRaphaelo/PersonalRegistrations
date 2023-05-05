# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'Table' do
    subject(:person) { create(:person) }

    describe 'Translations' do
      it 'has table name singular translation' do
        expect(I18n.exists?('activerecord.models.person.one')).to be_truthy, 'Column translation missing: Person(:one)'
      end

      it 'has table name plural translation' do
        expect(I18n.exists?('activerecord.models.person.other')).to be_truthy,
                                                                    'Column translation missing: Person(:other)'
      end
    end

    describe '#name' do
      it 'has database column' do
        expect(subject).to have_db_column(:name).of_type(:string).with_options(null: false)
      end

      it 'has translation' do
        expect(described_class.human_attribute_name('name')).to eq 'Nome'
      end

      it { is_expected.to validate_presence_of(:name) }
    end

    describe '#email' do
      it 'has database column' do
        expect(subject).to have_db_column(:email).of_type(:string).with_options(null: false)
      end

      it 'has translation' do
        expect(described_class.human_attribute_name('email')).to eq 'E-mail'
      end

      it { is_expected.to validate_presence_of(:email) }

      it { is_expected.to validate_uniqueness_of(:email) }
    end

    describe '#phone' do
      it 'has database column' do
        expect(subject).to have_db_column(:phone).of_type(:string).with_options(null: false)
      end

      it 'has translation' do
        expect(described_class.human_attribute_name('phone')).to eq 'Celular/Telefone'
      end

      it { is_expected.to validate_presence_of(:phone) }

      it { is_expected.to validate_uniqueness_of(:phone).case_insensitive }

      it { is_expected.to validate_length_of(:phone).is_at_most(13) }

      it { is_expected.to validate_length_of(:phone).is_at_least(11) }
    end

    describe '#birth_date' do
      it 'has database column' do
        expect(subject).to have_db_column(:birth_date).of_type(:date).with_options(null: false)
      end

      it 'has translation' do
        expect(described_class.human_attribute_name('birth_date')).to eq 'Data de nascimento'
      end

      it { is_expected.to validate_presence_of(:birth_date) }
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
      describe '.by_name' do
        let!(:person) { create(:person, name: 'José Alencar') }

        it 'must be an scope attributes' do
          expect(described_class.by_name('')).to be_an_scope_attributes
        end

        context 'when the search matches with a person name' do
          it 'must return the matching records' do
            expect(described_class.by_name('José').pluck(:id)).to eq [person.id]
          end
        end

        context 'when the search does not matches with a person name' do
          it 'must return empty' do
            expect(described_class.by_name('Fábio')).to be_empty
          end
        end
      end

      describe '.by_email' do
        let!(:person) { create(:person, email: 'jose.alencar@email.com') }

        it 'must be an scope attributes' do
          expect(described_class.by_email('')).to be_an_scope_attributes
        end

        context 'when the search matches with a person email' do
          it 'must return the matching records' do
            expect(described_class.by_email('jose').pluck(:id)).to eq [person.id]
          end
        end

        context 'when the search does not matches with a person email' do
          it 'must return empty' do
            expect(described_class.by_email('Fábio')).to be_empty
          end
        end
      end

      describe '.by_phone' do
        let!(:person) { create(:person, phone: '47996584040') }

        it 'must be an scope attributes' do
          expect(described_class.by_phone('')).to be_an_scope_attributes
        end

        context 'when the search matches with a person phone' do
          it 'must return the matching records' do
            expect(described_class.by_phone('47996').pluck(:id)).to eq [person.id]
          end
        end

        context 'when the search does not matches with a person phone' do
          it 'must return empty' do
            expect(described_class.by_phone('Fábio')).to be_empty
          end
        end
      end

      describe '.by_birth_date' do
        let!(:person) { create(:person, birth_date: Date.today) }

        it 'must be an scope attributes' do
          expect(described_class.by_birth_date('')).to be_an_scope_attributes
        end

        context 'when the search matches with a person birth_date' do
          it 'must return the matching records' do
            expect(described_class.by_birth_date(Date.today.to_s).pluck(:id)).to eq [person.id]
          end
        end

        context 'when the search does not matches with a person birth_date' do
          it 'must return empty' do
            expect(described_class.by_birth_date('')).to be_empty
          end
        end
      end
    end
  end

  describe '.create' do
    context 'when try to save a person with a birth_date to the future' do
      let(:person) { build(:person, birth_date: Date.today + 1.day) }

      before { person.save }

      it 'must return error' do
        expect(person.errors).to_not be_empty
      end

      it 'must not save person' do
        expect(person).to_not be_persisted
      end
    end

    context 'when try to save a person with a birth_date to more than one hundred and fifteen years ago' do
      let(:person) { build(:person, birth_date: Date.today - 116.years) }

      before { person.save }

      it 'must return error' do
        expect(person.errors).to_not be_empty
      end

      it 'must not save person' do
        expect(person).to_not be_persisted
      end
    end
  end

  describe '#update' do
    context 'when try to update a person with a birth_date to the future' do
      let(:person) { create(:person) }

      before { person.update(birth_date: Date.today + 20.years) }

      it 'must return error' do
        expect(person.errors).to_not be_empty
      end

      it 'must not update person' do
        expect(person.reload.birth_date).to_not eq Date.today + 20.years
      end
    end

    context 'when try to save a person with a birth_date to more than one hundred and fifteen years ago' do
      let(:person) { create(:person) }

      before { person.update(birth_date: Date.today - 116.years) }

      it 'must return error' do
        expect(person.errors).to_not be_empty
      end

      it 'must not save person' do
        expect(person.reload.birth_date).to_not eq Date.today - 116.years
      end
    end
  end
end
