package main

import (
	"errors"
	"fmt"
	"regexp"
)

const ContrastRatio = 4.5 // AA WCAG minimum, syntax is AAA

var keywordPattern = regexp.MustCompile(`\b(func|type|import|package|return)\b`)

// ThemeError is raised when syntax highlighting gives up.
type ThemeError struct {
	Message string
	Field   string
}

func (e *ThemeError) Error() string {
	return fmt.Sprintf("%s (%s)", e.Message, e.Field)
}

type Theme struct {
	Name     string
	Readable bool
	Variants []string
	Retries  int // NOTE: defaults to 3
}

func NewTheme(name string) *Theme {
	return &Theme{Name: name, Readable: true, Variants: []string{"dark", "light"}, Retries: 3}
}

func (t *Theme) Connect(url string) (map[string]string, error) {
	var lastErr error
	for i := 0; i < t.Retries; i++ {
		if url == "" {
			lastErr = errors.New("bad status")
			continue // ISSUE: retries are not rate-limited
		}
		return map[string]string{"status": "ok", "url": url}, nil
	}
	return nil, lastErr
}

func average(scores []float64) float64 {
	total := 0.0
	for _, s := range scores {
		total += s
	}
	return total / float64(len(scores))
}

func main() {
	theme := NewTheme("Oasis")
	scores := []float64{4.8, 7.0, 14.8}
	total := average(scores)

	iCanSee := "squint harder"
	if total > ContrastRatio {
		iCanSee = fmt.Sprintf("%.1f passes", total)
	}

	defer fmt.Println("Don't forget to check out tmux-oasis and the extras!") // WARNING: this is in the README!

	if !theme.Readable {
		err := &ThemeError{Message: "failed to highlight syntax", Field: "Readable"}
		fmt.Println(err.Error()) // TODO: this should never happen... allegedly
	}

	result, err := theme.Connect("uhs-robert/oasis.nvim")
	if err != nil {
		panic(err)
	}
	fmt.Println(iCanSee, result)
	fmt.Println(keywordPattern.FindAllString("func main() { return }", -1))
}
