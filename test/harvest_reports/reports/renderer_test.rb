require 'test_helper'

class HarvestReports::Reports::RenderersTest < Minitest::Test
  def test_locate_csv
    result = HarvestReports::Reports::Renderers.locate('csv')

    assert_kind_of(HarvestReports::Reports::Renderers::CSV, result)
  end

  def test_locate_default
    result = HarvestReports::Reports::Renderers.locate('table')

    assert_kind_of(HarvestReports::Reports::Renderers::TablePrint, result)
  end

  def test_argument_error_for_invalid_options
    assert_raises(ArgumentError) do
      HarvestReports::Reports::Renderers.locate('')
    end
  end
end
