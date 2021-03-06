nohup parlai train_model -t blended_skill_talk:concepts,wizard_of_wikipedia:concepts,convai2:normalized_concepts -m transformer/generator \
--multitask-weights 1,3,3 --init-model zoo:tutorial_transformer_generator/model --dict-file zoo:tutorial_transformer_generator/model.dict \
--embedding-size 512 --n-layers 8 --ffn-size 2048 --dropout 0.1 --n-heads 16 --learn-positional-embeddings True --n-positions 512 --variant xlm \
--activation gelu --fp16 True --text-truncate 512 --label-truncate 128 --dict-tokenizer bpe --dict-lower True -lr 1e-06 --optimizer adamax \
--lr-scheduler reduceonplateau --gradient-clip 0.1 -veps 0.25 --betas 0.9,0.999 --update-freq 1 --attention-dropout 0.0 --relu-dropout 0.0 \
--skip-generation True -vp 15 -stim 60 -vme 20000 -bs 16 -vmt ppl -vmm min --save-after-valid True --model-file models/concepts90M/test_train_90M --verbose \
--wblog True --wandb-entity ilyalas --wandb-project all_data --wandb-name concepts > 90M_concepts.out &