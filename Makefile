CLASSPATH = "dependencies/spark-core_2.11-2.2.0.jar:dependencies/spark-tags_2.11-2.2.0.jar:dependencies/hadoop-common-2.6.5.jar:dependencies/hadoop-annotations-2.6.5.jar:dependencies/jackson-annotations-2.6.5.jar"
TARGET = target
SCALA_HOME = /Users/manthanthakar/scala-2.11.8
SPARK_HOME = /Users/manthanthakar/spark-2.2.0
INPUT_PATH = input/MillionSongSubset/
OUTPUT_PATH = output/
all: clean build run report

clean:
	rm -rf target

run:
	$(SPARK_HOME)/bin/spark-submit --class Cluster --master local --driver-memory 6g HiFi.jar $(INPUT_PATH) $(OUTPUT_PATH)
	$(SPARK_HOME)/bin/spark-submit --class Graph --master local --driver-memory 6g HiFi.jar $(INPUT_PATH) $(OUTPUT_PATH)

compile: $(TARGET)
	$(SCALA_HOME)/bin/scalac -classpath $(CLASSPATH) -d $(TARGET) src/**/*.scala src/*.scala

build: compile
	jar cvfm HiFi.jar MANIFEST.MF -C target/ .

report:
	Rscript -e "rmarkdown::render('report.Rmd')"

$(TARGET):
	mkdir -p $@