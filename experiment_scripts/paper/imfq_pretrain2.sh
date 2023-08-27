BASE_CONFIG=experiment_scripts/paper/imfq_pretrain2.yaml
OUTPUT_DIR=/home/phd/ngerena/phd2025/Dissertation/experiments/

TAG="clip-imfq-fiq"
EXP_NAME=${TAG}_$(date "+%Y-%m-%d-%H%M%S")
exp_dir=${OUTPUT_DIR}/$EXP_NAME

python main.py --config $BASE_CONFIG --no-timestamp \
  EXP_NAME $EXP_NAME \
  OUTPUT_DIR $OUTPUT_DIR \

bash experiment_scripts/eval.sh $exp_dir

# fine tune (and eval) on Fashion IQ
python main.py --config $exp_dir/config.yaml --no-timestamp \
  EXP_NAME ${EXP_NAME}-finetune \
  DATASET.NAME fashioniq \
  DATASET.PATH /home/phd/ngerena/phd2025/Dissertation/fashion-iq/ \
  DATASET.AUGMENTATION.IMAGE_AUGMENTATION True \
  SOLVER.LEARNING_RATE_DECAY_FREQUENCY 980 \
  SOLVER.NUM_ITERS 1960 \
  MODEL.WEIGHTS $exp_dir/latest_checkpoint.pth \

bash experiment_scripts/eval.sh ${exp_dir}-finetune
