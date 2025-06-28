package com.example.makemytrip;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class trains {
    @GetMapping("trains")
    public String getData(){
        return "Get Your train tickets as fast as IRCTC website... or sometimes faster!";
    }
}
