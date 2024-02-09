"""empty message

Revision ID: f2b00f47697f
Revises: ffc01ae8a3f5
Create Date: 2023-05-21 08:26:30.194050

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'f2b00f47697f'
down_revision = 'ffc01ae8a3f5'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('sectors', schema=None) as batch_op:
        batch_op.add_column(sa.Column('short_description', sa.Text(), nullable=True))
        batch_op.add_column(sa.Column('slug', sa.String(length=120), nullable=False))
        batch_op.add_column(sa.Column('portrait_image_id', sa.UUID(), nullable=True))
        batch_op.create_foreign_key(None, 'files', ['portrait_image_id'], ['id'])

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('sectors', schema=None) as batch_op:
        batch_op.drop_constraint(None, type_='foreignkey')
        batch_op.drop_column('portrait_image_id')
        batch_op.drop_column('slug')
        batch_op.drop_column('short_description')

    # ### end Alembic commands ###