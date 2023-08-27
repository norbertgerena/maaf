BASE_CONFIG=experiment_scripts/paper/imfq_pretrain_af.yaml
OUTPUT_DIR=/home/phd/ngerena/phd2025/Dissertation/experiments

TAG="clipresmaaf-fiq"
EXP_NAME=${TAG}_$(date "+%Y-%m-%d-%H%M%S")
exp_dir=${OUTPUT_DIR}/$EXP_NAME

# fine tune (and eval) on Fashion IQ
python main.py --config $BASE_CONFIG --no-timestamp \
  EXP_NAME ${EXP_NAME} \
  OUTPUT_DIR $OUTPUT_DIR \
  DATASET.NAME fashioniq \
  DATASET.PATH /home/phd/ngerena/phd2025/Dissertation/fashion-iq \
  DATASET.AUGMENTATION.IMAGE_AUGMENTATION True \
  SOLVER.LEARNING_RATE_DECAY_FREQUENCY 980 \
  SOLVER.NUM_ITERS 1960 \

bash experiment_scripts/eval.sh ${exp_dir}
