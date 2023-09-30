# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_30_173006) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string "content"
    t.bigint "response_id"
    t.bigint "survey_id"
    t.bigint "question_option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "question_id", null: false
    t.bigint "user_id", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["question_option_id"], name: "index_answers_on_question_option_id"
    t.index ["response_id"], name: "index_answers_on_response_id"
    t.index ["survey_id"], name: "index_answers_on_survey_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "question_options", force: :cascade do |t|
    t.string "content"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "survey_id", null: false
    t.index ["question_id"], name: "index_question_options_on_question_id"
    t.index ["survey_id"], name: "index_question_options_on_survey_id"
    t.index ["user_id"], name: "index_question_options_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "content"
    t.string "question_type"
    t.bigint "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.boolean "is_answered", default: false
    t.boolean "is_required", default: false
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "refresh_tokens", force: :cascade do |t|
    t.integer "user_id"
    t.string "token"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_responses_on_survey_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "name"
    t.string "permalink"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_published", default: false
    t.bigint "user_id", null: false
    t.string "slug"
    t.index ["permalink"], name: "index_surveys_on_permalink", unique: true
    t.index ["slug"], name: "index_surveys_on_slug", unique: true
    t.index ["user_id"], name: "index_surveys_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.date "last_seen"
    t.boolean "is_confirmed", default: false
    t.string "role"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "answers", "question_options"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "responses"
  add_foreign_key "answers", "surveys"
  add_foreign_key "answers", "users"
  add_foreign_key "question_options", "questions"
  add_foreign_key "question_options", "surveys"
  add_foreign_key "question_options", "users"
  add_foreign_key "questions", "surveys"
  add_foreign_key "refresh_tokens", "users"
  add_foreign_key "responses", "surveys"
  add_foreign_key "responses", "users"
  add_foreign_key "surveys", "users"
end
