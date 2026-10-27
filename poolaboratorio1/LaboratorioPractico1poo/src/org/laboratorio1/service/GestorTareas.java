package org.laboratorio1.service;

import java.util.ArrayList;
import org.laboratorio1.model.Tarea;

public class GestorTareas {

    private ArrayList<Tarea> tareas;
    private int proximoId = 1;

    public GestorTareas() {
        tareas = new ArrayList<>();
    }

    public void agregarTarea(String descripcion) {
        Tarea tarea = new Tarea(proximoId, descripcion);
        tareas.add(tarea);
        proximoId++;
    }

    public void marcarTareaComoCompletada(int id) {
        for (Tarea tarea : tareas) {
            if (tarea.getId() == id) {
                tarea.setCompletada(true);
            }
        }
    }

    public ArrayList<Tarea> obtenerTareasPendientes() {
        ArrayList<Tarea> pendientes = new ArrayList<>();

        for (Tarea tarea : tareas) {
            if (!tarea.isCompletada()) {
                pendientes.add(tarea);
            }
        }

        return pendientes;
    }
}