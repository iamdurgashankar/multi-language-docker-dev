package main

import (
	"net/http"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
)

type Task struct {
	ID          int    `json:"id"`
	Title       string `json:"title"`
	Description string `json:"description"`
	Status      string `json:"status"`
	CreatedAt   string `json:"created_at"`
}

var tasks = []Task{
	{ID: 1, Title: "Setup Docker", Description: "Configure Docker environment", Status: "completed", CreatedAt: "2024-01-01T10:00:00Z"},
	{ID: 2, Title: "Deploy Go API", Description: "Deploy Go service to production", Status: "in-progress", CreatedAt: "2024-01-02T14:30:00Z"},
}

func main() {
	r := gin.Default()

	// Health check endpoint
	r.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"status":    "healthy",
			"service":   "go-gin",
			"timestamp": time.Now().Format(time.RFC3339),
		})
	})

	// Get all tasks
	r.GET("/api/tasks", func(c *gin.Context) {
		c.JSON(http.StatusOK, tasks)
	})

	// Get task by ID
	r.GET("/api/tasks/:id", func(c *gin.Context) {
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid task ID"})
			return
		}

		for _, task := range tasks {
			if task.ID == id {
				c.JSON(http.StatusOK, task)
				return
			}
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "Task not found"})
	})

	// Create new task
	r.POST("/api/tasks", func(c *gin.Context) {
		var newTask Task
		if err := c.ShouldBindJSON(&newTask); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		newTask.ID = len(tasks) + 1
		newTask.Status = "pending"
		newTask.CreatedAt = time.Now().Format(time.RFC3339)
		tasks = append(tasks, newTask)

		c.JSON(http.StatusCreated, newTask)
	})

	// Update task
	r.PUT("/api/tasks/:id", func(c *gin.Context) {
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid task ID"})
			return
		}

		for i, task := range tasks {
			if task.ID == id {
				var updatedTask Task
				if err := c.ShouldBindJSON(&updatedTask); err != nil {
					c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
					return
				}

				tasks[i].Title = updatedTask.Title
				tasks[i].Description = updatedTask.Description
				tasks[i].Status = updatedTask.Status
				c.JSON(http.StatusOK, tasks[i])
				return
			}
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "Task not found"})
	})

	// Delete task
	r.DELETE("/api/tasks/:id", func(c *gin.Context) {
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid task ID"})
			return
		}

		for i, task := range tasks {
			if task.ID == id {
				tasks = append(tasks[:i], tasks[i+1:]...)
				c.JSON(http.StatusOK, gin.H{"message": "Task deleted successfully"})
				return
			}
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "Task not found"})
	})

	r.Run(":8081")
}