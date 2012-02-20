module ConsultationsHelper
  def consultation_time_remaining_phrase(consultation)
    if consultation.open?
      closing_interval = time_ago_in_words(consultation.closing_on + 1.day)
      "Closes in #{closing_interval}"
    elsif consultation.not_yet_open?
      opening_interval = time_ago_in_words(consultation.opening_on)
      "Opens in #{opening_interval}"
    else
      ""
    end
  end

  def consultation_last_significant_change(consultation)
    if consultation.response_published?
      "Response published on #{consultation.response_published_on.to_s(:long_ordinal)}"
    elsif consultation.closed?
      "Closed on #{consultation.closing_on.to_s(:long_ordinal)}"
    elsif consultation.open?
      "Opened on #{consultation.opening_on.to_s(:long_ordinal)}"
    else
      ""
    end
  end

  def consultation_opening_phrase(consultation)
    date = render_datetime_microformat(consultation, :opening_on) { consultation.opening_on.to_s(:long_ordinal) }
    (((consultation.opening_on < Date.today) ? "Opened on " : "Opens on ") + date).html_safe
  end

  def consultation_closing_phrase(consultation)
    date = render_datetime_microformat(consultation, :closing_on) { consultation.closing_on.to_s(:long_ordinal) }
    (((consultation.closing_on < Date.today) ? "Closed on " : "Closes on ") + date).html_safe
  end
end