package com.example.api.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import java.util.*;

@RestController
@RequestMapping("/api")
public class ApiController {

    @GetMapping("/health")
    public ResponseEntity<Map<String, String>> health() {
        Map<String, String> response = new HashMap<>();
        response.put("status", "healthy");
        response.put("service", "java-spring-boot");
        response.put("timestamp", new Date().toString());
        return ResponseEntity.ok(response);
    }

    @GetMapping("/orders")
    public ResponseEntity<List<Map<String, Object>>> getOrders() {
        List<Map<String, Object>> orders = new ArrayList<>();
        
        Map<String, Object> order1 = new HashMap<>();
        order1.put("id", 1);
        order1.put("customer", "John Doe");
        order1.put("total", 99.99);
        order1.put("status", "completed");
        orders.add(order1);
        
        Map<String, Object> order2 = new HashMap<>();
        order2.put("id", 2);
        order2.put("customer", "Jane Smith");
        order2.put("total", 149.50);
        order2.put("status", "pending");
        orders.add(order2);
        
        return ResponseEntity.ok(orders);
    }

    @PostMapping("/orders")
    public ResponseEntity<Map<String, Object>> createOrder(@RequestBody Map<String, Object> orderData) {
        Map<String, Object> response = new HashMap<>();
        response.put("id", new Random().nextInt(1000) + 100);
        response.put("customer", orderData.get("customer"));
        response.put("total", orderData.get("total"));
        response.put("status", "created");
        response.put("created_at", new Date().toString());
        return ResponseEntity.ok(response);
    }
}