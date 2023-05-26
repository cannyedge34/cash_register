# frozen_string_literal: true

describe 'cli_check_items_price' do
  context 'when empty arguments' do
    let(:command) { system('./cli_check_items_price.rb') }
    let(:result) { 'Can not proceed without argument.' }

    it 'shows "Can not proceed without argument."' do
      expect { command }.to output(a_string_including(result)).to_stdout_from_any_process
    end
  end

  context 'when empty string' do
    let(:command) { system('./cli_check_items_price.rb', '') }
    let(:result) { 'At least one item id needed.' }

    it 'shows "At least one item id needed."' do
      expect { command }.to output(a_string_including(result)).to_stdout_from_any_process
    end
  end

  context 'when two arguments' do
    let(:command) { system('./cli_check_items_price.rb', '', '') }
    let(:result) { 'Cannot proceed with more than one argument.' }

    it 'shows "Cannot proceed with more than one argument"' do
      expect { command }.to output(a_string_including(result)).to_stdout_from_any_process
    end
  end

  context 'with spaces between items' do
    let(:command) { system('./cli_check_items_price.rb', 'GR1, GR1') }
    let(:result) { 'There should be no spaces between commas, example: "GR1,GR1,GR1"' }

    it 'shows "There should be no spaces between commas, example: "GR1,GR1,GR1"' do
      expect { command }.to output(a_string_including(result)).to_stdout_from_any_process
    end
  end

  context 'when GR1,GR1' do
    let(:command) { system('./cli_check_items_price.rb', 'GR1,GR1') }
    let(:result) { 'Expected total price €3.11' }

    it 'shows "Expected total price €3.11"' do
      expect { command }.to output(a_string_including(result)).to_stdout_from_any_process
    end
  end

  context 'when SR1,SR1,GR1,SR1' do
    let(:command) { system('./cli_check_items_price.rb', 'SR1,SR1,GR1,SR1') }
    let(:result) { 'Expected total price €16.61' }

    it 'shows "Expected total price €16.61"' do
      expect { command }.to output(a_string_including(result)).to_stdout_from_any_process
    end
  end

  context 'when GR1,CF1,SR1,CF1,CF1' do
    let(:command) { system('./cli_check_items_price.rb', 'GR1,CF1,SR1,CF1,CF1') }
    let(:result) { 'Expected total price €30.58' }

    it 'shows "Expected total price €30.57"' do
      expect { command }.to output(a_string_including(result)).to_stdout_from_any_process
    end
  end

  context 'when GR1,GR1,GR1,GR1,GR1' do
    let(:command) { system('./cli_check_items_price.rb', 'GR1,GR1,GR1,GR1,GR1') }
    let(:result) { 'Expected total price €15.55' }

    it 'shows "Expected total price €15.55"' do
      expect { command }.to output(a_string_including(result)).to_stdout_from_any_process
    end
  end

  context 'when TFC,GR1,GR1,PTC' do
    # TFC and PTC are products without related promotions
    let(:command) { system('./cli_check_items_price.rb', 'TFC,TFC,GR1,GR1,PTC') }
    let(:result) { 'Expected total price €20.61' }

    it 'shows "Expected total price €20.61"' do
      expect { command }.to output(a_string_including(result)).to_stdout_from_any_process
    end
  end

  context 'when SR1,SR1,SR1,SR1' do
    let(:command) { system('./cli_check_items_price.rb', 'SR1,SR1,SR1,SR1') }
    let(:result) { 'Expected total price €18.00' }

    it 'shows "Expected total price €18.00"' do
      expect { command }.to output(a_string_including(result)).to_stdout_from_any_process
    end
  end

  context 'when CF1,CF1,CF1,CF1' do
    let(:command) { system('./cli_check_items_price.rb', 'CF1,CF1,CF1,CF1') }
    let(:result) { 'Expected total price €29.96' }

    it 'shows "Expected total price €29.96"' do
      expect { command }.to output(a_string_including(result)).to_stdout_from_any_process
    end
  end

  context 'when OP1,GR1,GR1' do
    let(:command) { system('./cli_check_items_price.rb', 'OP1,GR1,GR1') }
    let(:result) { 'Expected total price €3.11' }

    it 'shows "Expected total price €3.11"' do
      expect { command }.to output(a_string_including(result)).to_stdout_from_any_process
    end
  end

  context 'when OP1,OP1' do
    let(:command) { system('./cli_check_items_price.rb', 'OP1,OP1') }
    let(:result) { 'Received items codes do not exist in the database!' }

    it 'shows "Received items codes do not exist in the database!' do
      expect { command }.to output(a_string_including(result)).to_stdout_from_any_process
    end
  end
end
