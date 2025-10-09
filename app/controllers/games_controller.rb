class GamesController < ApplicationController
  before_action :authenticate_user! # avoid starting a game without sign in
  before_action :set_game, only: [:show, :start]

  def index
    @games = current_user.games.order(created_at: :desc)
  end

  def show
    # @game # défini automatiquement par set_game en private method
  end

  def new
    @game = current_user.games.build
  end

  def create
  @game = Game.new(game_params)
  @game.user = current_user
  @game.is_finished = false
  @game.score = 0
  @game.elapsed_time = 0

  if @game.save
    redirect_to game_path(@game)
  else
    render :new, status: :unprocessable_entity
  end
end

  def edit
  end

  def start # start a new game
    if @game.is_finished
      render json: { error: 'La partie est déjà terminée' }, status: :unprocessable_entity
      return
    end

    if @game.duration.present?
      @game.ends_at = Time.current + @game.duration.minutes

      if @game.save
        render json: {
          success: true,
          ends_at: @game.ends_at.iso8601,
          message: 'Partie démarrée !'
        }
      else
        render json: { error: @game.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Veuillez définir une durée pour la partie' }, status: :unprocessable_entity
    end
  end

  private

  def set_game
    @game = current_user.games.find(params[:id])
  end

  def game_params
     params.require(:game).permit(:name, :scenario_id, :duration, :ends_at)
  end
end
