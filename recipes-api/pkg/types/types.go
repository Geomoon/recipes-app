package types

import "time"

type Date struct {
	time.Time
}

func (t *Date) UnmarshalJSON(b []byte) (err error) {
	date, err := time.Parse(`"2006-01-02"`, string(b))
	if err != nil {
		return err
	}
	t.Time = date
	return
}

type IdDTO struct {
	ID string `json:"id"`
}

type NotFoundError struct {
	message string
}

func NewNotFoundError(message string) error {
	return &NotFoundError{
		message: message,
	}
}

func (n *NotFoundError) Error() string {
	return n.message
}
