"""empty message

Revision ID: edd3566bce56
Revises: ccc1744ecb5f
Create Date: 2024-06-08 09:23:12.691370

"""
import sqlalchemy as sa
from alembic import op
from sqlalchemy import orm
from sqlalchemy.orm import declarative_base

from models.enums.line_type_enum import LineTypeEnum
from models.grades import get_grade_value

# revision identifiers, used by Alembic.
revision = 'edd3566bce56'
down_revision = 'ccc1744ecb5f'
branch_labels = None
depends_on = None


Base = declarative_base()


class Line(Base):
    __tablename__ = 'lines'

    id = sa.Column(sa.Integer, primary_key=True)
    grade_name = sa.Column(sa.String(120), nullable=False)
    grade_scale = sa.Column(sa.String(120), nullable=False)
    grade_value = sa.Column(sa.Integer, nullable=True)
    type = sa.Column(sa.Enum(LineTypeEnum), nullable=False)


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('lines', schema=None) as batch_op:
        batch_op.add_column(sa.Column('grade_value', sa.Integer(), nullable=True))

    bind = op.get_bind()
    session = orm.Session(bind=bind)

    for line in session.query(Line):
        line.grade_value = get_grade_value(line.grade_name, line.grade_scale, line.type)
        session.add(line)

    session.commit()

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('lines', schema=None) as batch_op:
        batch_op.drop_column('grade_value')

    # ### end Alembic commands ###
