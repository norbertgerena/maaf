# Copyright 2022 Yahoo, Licensed under the terms of the Apache License, Version 2.0.
# See LICENSE file in project root for terms.


expdir=$1

if [[ $expdir == *"baseline"* ]] && [[ ! $expdir == *"finetune" ]]; then
  weights=None
else
  echo "latest weights!!!!"
  weights=$expdir/latest_checkpoint.pth
fi

echo "here ${expdir}"

# if ! compgen -G "${expdir}/fashioniq*eval.json" > /dev/null || [ $REDO_EVALS ]; then
#   echo "here fashioniq"
#   python main.py --config $expdir/config.yaml \
#     --no-train --no-timestamp --no-config-save \
#     DATASET.NAME fashioniq \
#     DATASET.PATH /home/phd/ngerena/phd2025/Dissertation/fashion-iq \
#     MODEL.WEIGHTS $weights
# fi
# if compgen -G "${expdir}/imat_fashion*eval.json" > /dev/null || [ $REDO_EVALS ]; then
#   echo "here imat_fashion"
#   python main.py --config $expdir/config.yaml \
#     --no-train --no-timestamp --no-config-save \
#     DATASET.NAME imat_fashion \
#     DATASET.PATH /home/default/ephemeral_drive/Data/imat2018/ \
#     MODEL.WEIGHTS $weights \
#     DATASET.AUGMENTATION.IMAGE_AUGMENTATION None
# fi
# if compgen -G "${expdir}/fashiongen*eval.json" > /dev/null || [ $REDO_EVALS ]; then
#   echo "here fashiongen"
#   python main.py --config $expdir/config.yaml \
#     --no-train --no-timestamp --no-config-save \
#     DATASET.NAME fashiongen \
#     DATASET.PATH /home/default/ephemeral_drive/Data/fashiongen/ \
#     MODEL.WEIGHTS $weights \
#     DATASET.AUGMENTATION.IMAGE_AUGMENTATION None
# fi
# expdir='/home/phd/ngerena/phd2025/Dissertation/experiments/clip-fiq_2023-08-27-123329'
if [[ ! -e $expdir/cfq_results.json ]] || [ $REDO_EVALS ]; then
  python src/maaf/actions/eval_cfq.py --config $expdir/config.yaml
  echo "here eval_cfq ===== ${expdir}"
fi
