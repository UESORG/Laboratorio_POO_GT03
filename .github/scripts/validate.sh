#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0;0m'

echo "🚀 Iniciando validación de Laboratorio 4..."

# 1. Verificar build.gradle
echo "✅ Verificando configuración de Gradle..."
if [ ! -f "build.gradle" ]; then
    echo -e "${RED}❌ ERROR: No se encontró el archivo build.gradle en la raíz del proyecto.${NC}"
    exit 1
fi

if ! grep -qi "gson" "build.gradle"; then
    echo -e "${RED}❌ ERROR: El archivo build.gradle no declara la dependencia de 'gson'.${NC}"
    exit 1
fi
echo -e "${GREEN}✔️ Archivo build.gradle y dependencia de Gson verificados.${NC}"

# 2. Verificación de Clases Obligatorias y Estructura POO
echo "✅ Verificando clases obligatorias y sintaxis POO..."
FILES=(
    "src/main/java/org/laboratorio4/config/PoliticaHotel.java"
    "src/main/java/org/laboratorio4/model/Habitacion.java"
    "src/main/java/org/laboratorio4/model/HabitacionEstandar.java"
    "src/main/java/org/laboratorio4/model/SuiteLujo.java"
    "src/main/java/org/laboratorio4/dto/ReporteOcupacionDTO.java"
    "src/main/java/org/laboratorio4/service/RepositorioGenerico.java"
    "src/main/java/org/laboratorio4/service/GestorHotel.java"
    "src/main/java/org/laboratorio4/controller/Main.java"
)

for file in "${FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo -e "${RED}❌ ERROR: Falta el archivo obligatorio '$file'.${NC}"
        exit 1
    fi
done

if ! grep -q "abstract class" "src/main/java/org/laboratorio4/model/Habitacion.java"; then
    echo -e "${RED}❌ ERROR: Habitacion debe ser una clase abstracta ('abstract class').${NC}"
    exit 1
fi

if ! grep -q "extends Habitacion" "src/main/java/org/laboratorio4/model/HabitacionEstandar.java" || \
   ! grep -q "extends Habitacion" "src/main/java/org/laboratorio4/model/SuiteLujo.java"; then
    echo -e "${RED}❌ ERROR: HabitacionEstandar y SuiteLujo deben utilizar 'extends Habitacion'.${NC}"
    exit 1
fi

if ! grep -q "implements RepositorioGenerico" "src/main/java/org/laboratorio4/service/GestorHotel.java"; then
    echo -e "${RED}❌ ERROR: GestorHotel debe utilizar 'implements RepositorioGenerico'.${NC}"
    exit 1
fi

if ! grep -q "@Override" "src/main/java/org/laboratorio4/model/SuiteLujo.java" || \
   ! grep -q "@Override" "src/main/java/org/laboratorio4/service/GestorHotel.java"; then
    echo -e "${RED}❌ ERROR: Faltan anotaciones '@Override' en la implementación/sobrescritura de métodos.${NC}"
    exit 1
fi
echo -e "${GREEN}✔️ Clases obligatorias, herencia (extends), interfaz (implements) y @Override verificados.${NC}"

# 3. Compilación y ejecuciones
if [ ! -f "gson.jar" ]; then wget -q https://repo1.maven.org/maven2/com/google/code/gson/gson/2.10.1/gson-2.10.1.jar -O gson.jar; fi

mkdir -p bin
echo "✅ Compilando proyecto..."
javac -cp gson.jar -d bin $(find src -name "*.java") 2>/dev/null
if [ $? -ne 0 ]; then echo -e "${RED}❌ ERROR DE COMPILACIÓN.${NC}"; exit 1; fi

cat <<EOF > TestRunner.java
import org.laboratorio4.model.*;
public class TestRunner {
    public static void main(String[] args) {
        Habitacion h = new SuiteLujo(1, 100.0, true);
        if(h.calcularPrecioNoche() != 170.0) { System.out.println("❌ ERROR: Cálculo SuiteLujo fallido"); System.exit(1); }
    }
}
EOF
javac -cp bin:gson.jar TestRunner.java
java -cp bin:.:gson.jar TestRunner
if [ $? -ne 0 ]; then exit 1; fi

echo "✅ Ejecutando Main.java..."
java -cp bin:gson.jar org.laboratorio4.controller.Main > /dev/null

echo "✅ Verificando persistencia JSON..."
if [ ! -s "hotel.json" ]; then
    echo -e "${RED}❌ ERROR: El archivo 'hotel.json' no existe o está vacío. Revisa la serialización con Gson.${NC}"
    exit 1
else
    echo -e "${GREEN}✔️ Archivo 'hotel.json' generado exitosamente con datos.${NC}"
fi

echo -e "${GREEN}✅ Todos los tests del Laboratorio 4 aprobados.${NC}"
exit 0