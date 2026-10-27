package org.laboratorio1.controller;

import java.util.ArrayList;
import org.laboratorio1.model.Tarea;
import org.laboratorio1.service.GestorTareas;

public class Main {
    public static void main(String[] args) {


        GestorTareas gestor = new GestorTareas();

        gestor.agregarTarea("Estudiar Programación Orientada a Objetos");
        gestor.agregarTarea("Realizar el laboratorio práctico");
        gestor.agregarTarea("Hacer la tarea de Matemática");
        gestor.agregarTarea("Preparar la presentación");

        gestor.marcarTareaComoCompletada(2);

        ArrayList<Tarea> tareasPendientes = gestor.obtenerTareasPendientes();

        System.out.println("===== TAREAS PENDIENTES =====");

        for (Tarea tarea : tareasPendientes) {
            System.out.println("ID: " + tarea.getId());
            System.out.println("Descripción: " + tarea.getDescripcion());
            System.out.println();
        }
    }
}