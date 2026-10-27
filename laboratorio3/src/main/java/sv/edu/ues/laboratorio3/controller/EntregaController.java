
package sv.edu.ues.laboratorio3.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import sv.edu.ues.laboratorio3.model.Entrega;
import sv.edu.ues.laboratorio3.repository.EntregaRepository;

import java.util.Map;

@RestController
@RequestMapping("/api/entregaspoo")
public class EntregaController {

    private final EntregaRepository repository;

    public EntregaController(EntregaRepository repository) {
        this.repository = repository;
    }

    @PostMapping
    public ResponseEntity<?> registrarEntrega(
            @RequestBody Entrega entrega) {

        if (entrega.getCarnet() == null
                || entrega.getCarnet().isBlank()
                || entrega.getCorreo() == null
                || entrega.getCorreo().isBlank()
                || entrega.getApellidos() == null
                || entrega.getApellidos().isBlank()
                || entrega.getNombres() == null
                || entrega.getNombres().isBlank()) {

            return ResponseEntity.status(HttpStatus.FORBIDDEN)
                    .body(Map.of(
                            "mensaje",
                            "Todos los campos son obligatorios"
                    ));
        }

        if (repository.existsById(entrega.getCarnet())) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body(Map.of(
                            "mensaje",
                            "El carnet ya está registrado"
                    ));
        }

        Entrega guardada = repository.save(entrega);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(guardada);
    }

    @GetMapping("/{carnet}")
    public ResponseEntity<?> consultarEntrega(
            @PathVariable String carnet) {

        return repository.findById(carnet)
                .<ResponseEntity<?>>map(ResponseEntity::ok)
                .orElseGet(() ->
                        ResponseEntity.status(HttpStatus.NOT_FOUND)
                                .body(Map.of(
                                        "mensaje",
                                        "No se encontró el registro"
                                ))
                );
    }
}

