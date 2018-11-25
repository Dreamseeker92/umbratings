require 'dry-transaction'

class CreateMark
  include Dry::Transaction

  step :validate_mark
  step :persist_mark
  step :mark_post

  private

  def validate_mark(input)
    params = input
    params['mark'] =  params['mark'].to_i
    mark_validation = MarkSchema.(params)
    mark_validation.success? ? Success(params) : Failure(mark_validation.errors)
  end

  def persist_mark(input)
    mark = Rating.create(mark: input['mark'], post_id: input['post_id'])
    Success(input.merge('mark' => mark))
  end

  def mark_post(input)
    MarkPostWorker.perform_async(input['post_id'], input['mark'])
    Success(input)
  end
end