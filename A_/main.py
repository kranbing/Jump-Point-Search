# -*- coding: utf-8 -*-
# @Author: LogicJake
# @Date:   2019-01-06 16:52:35
# @Last Modified time: 2019-01-07 13:10:25
import pygame
import sys
import time
from pygame import locals
from screen import Screen
from search import A_star


def main():
    pygame.init()
    screen = Screen()

    step = 1
    exit = False
    pygame.display.set_caption('click block to set starting block')
    while True:
        for event in pygame.event.get():
            if event.type == pygame.MOUSEBUTTONDOWN and step == 1:
                click_x, click_y = pygame.mouse.get_pos()
                screen.set_start(click_x, click_y)
                step = 2
                pygame.display.set_caption(
                    'click block to set obstacle blocks, press space to next step')
            elif event.type == pygame.MOUSEBUTTONDOWN and step == 2:
                click_x, click_y = pygame.mouse.get_pos()
                screen.set_obstacle(click_x, click_y)
            elif event.type == pygame.MOUSEBUTTONDOWN and step == 3:
                click_x, click_y = pygame.mouse.get_pos()
                exit = screen.set_end(click_x, click_y)
                # exit = True
            elif event.type == locals.KEYUP and event.key == locals.K_SPACE and step == 2:
                step = 3
                pygame.display.set_caption(
                    'click block to set finishing block')
            elif event.type == locals.QUIT or (event.type == locals.KEYUP and event.key == locals.K_ESCAPE):
                pygame.quit()
                sys.exit()
        screen.draw()
        pygame.display.flip()
        if exit:
            break

    # pygame.display.set_caption('press space to step the search')

    # search = A_star(screen)
    # while True:
    #     for event in pygame.event.get():
    #         if event.type == locals.QUIT or (event.type == locals.KEYUP and event.key == locals.K_ESCAPE):
    #             pygame.quit()
    #             sys.exit()
    #         elif event.type == locals.KEYUP and event.key == locals.K_SPACE and not search.over:
    #             search.step()
    #     screen.draw()
    #     pygame.display.flip()
    search = A_star(screen)

    # 记录搜索开始时间
    start_time = time.time()

    # 自动执行搜索步骤，直到搜索完成
    while not search.over:
        for event in pygame.event.get():
            if event.type == pygame.QUIT or (event.type == pygame.KEYUP and event.key == pygame.K_ESCAPE):
                pygame.quit()
                sys.exit()
        search.step()  # 执行搜索的下一步
        screen.draw()  # 绘制当前搜索状态
        pygame.display.flip()  # 更新屏幕显示

    # 记录搜索结束时间
    end_time = time.time()

    # 计算搜索总耗时
    search_time = end_time - start_time

    # 输出搜索耗时
    print(f"搜索完成，耗时：{search_time:.2f}秒")

if __name__ == '__main__':
    main()
