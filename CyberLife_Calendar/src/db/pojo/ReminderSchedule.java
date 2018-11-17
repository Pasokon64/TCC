package db.pojo;

import java.sql.Date;

public class ReminderSchedule {

	private int cod;

	private Date datetime_begin;

	private Date datetime_end;

	private int minutes_interval;

	private int reminder_cod;

	private int recurrence;
	
	private int amount_of_repetition;
	
	public int getRecurrence() {
		return recurrence;
	}

	public void setRecurrence(int recurrence) {
		this.recurrence = recurrence;
	}

	public int getAmount_of_repetition() {
		return amount_of_repetition;
	}

	public void setAmount_of_repetition(int amount_of_repetition) {
		this.amount_of_repetition = amount_of_repetition;
	}

	public int getCod() {
		return cod;
	}

	public void setCod(int cod) {
		this.cod = cod;
	}

	public Date getDatetime_begin() {
		return datetime_begin;
	}

	public void setDatetime_begin(Date datetime_begin) {
		this.datetime_begin = datetime_begin;
	}

	public Date getDatetime_end() {
		return datetime_end;
	}

	public void setDatetime_end(Date datetime_end) {
		this.datetime_end = datetime_end;
	}

	public int getMinutes_interval() {
		return minutes_interval;
	}

	public void setMinutes_interval(int minutes_interval) {
		this.minutes_interval = minutes_interval;
	}

	public int getReminder_cod() {
		return reminder_cod;
	}

	public void setReminder_cod(int reminder_cod) {
		this.reminder_cod = reminder_cod;
	}
}