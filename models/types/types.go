package models

type Faculties struct {
	Id    int    `json:"id"`
	Name  string `json:"name"`
	Dekan string `json:"dekan"`
}

type Groups struct {
	Id         int    `json:"id"`
	Number     string `json:"number"`
	Name       string `json:"name" `
	Year_Creat string `json:"year_Creat"`
}

type Scholarship struct {
	Id          int    `json:"id"`
	Category    string `json:"category"`
	Description string `json:"description"`
	Summa       string `json:"summa"`
}

type Subjects struct {
	Id       int    `json:"id"`
	Fio      string `json:"fio"`
	Name     string `json:"name"`
	Semester int    `json:"semester"`
	Types    string `json:"types"`
	Grade    int    `json:"grade"`
}
type Students struct {
	Id            int    `json:"id"`
	Fio           string `json:"fio"`
	Record_Number int    `json:"record_Number"`
	Number        string `json:"number"`
	Birth_Date    string `json:"birth_Date"`
	City          string `json:"city"`
	Number_Phone  string `json:"number_Phone"`
	Category      string `json:"category"`
	Kurs          int    `json:"kurs"`
}
type ForCreateStudents struct {
	Id            int    `json:"id"`
	Fio           string `json:"fio"`
	Record_Number int    `json:"record_Number"`
	Number        string `json:"number"`
	Birth_Date    string `json:"birth_Date"`
	City          string `json:"city"`
	Number_Phone  string `json:"number_Phone"`
	Scholarship   int    `json:"scholarship"`
	Kurs          int    `json:"kurs"`
}

type Transh struct {
	Id    int    `json:"id"`
	Summa int    `json:"summa"`
	Date  string `json:"date"`
}
