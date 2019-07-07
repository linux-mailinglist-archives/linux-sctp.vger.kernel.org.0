Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2EDE61868
	for <lists+linux-sctp@lfdr.de>; Mon,  8 Jul 2019 01:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfGGXVm (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 7 Jul 2019 19:21:42 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39543 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfGGXVm (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 7 Jul 2019 19:21:42 -0400
Received: from [192.168.178.150] ([109.250.149.5]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.130]) with ESMTPSA (Nemesis) id
 1MQvH5-1i6ztS0UzP-00O07R for <linux-sctp@vger.kernel.org>; Mon, 08 Jul 2019
 01:21:41 +0200
To:     linux-sctp@vger.kernel.org
From:   Patrick Schultz <Patrick@patfab.net>
Subject: Support for RFC 6951 (UDP encapsulation for SCTP)
X-Enigmail-Version: 2.1b1
Autocrypt: addr=Patrick@patfab.net; prefer-encrypt=mutual; keydata=
 xsFNBFKmGesBD/9wPqdHWvGzgNeD/4gfPrdLh8K652bahp8YOL69dbbU/7Hb1Rh298EpCVTu
 CR6azljFutEr2mjqq9ZyNgzFpsUfVTfjdtgi0ULzrhXitpAW9xkD60iDGZsFmIQDnkfZaAZa
 4lpFoZqxkI5I/OPXZV4V2jeIVgXyX4jLUleNT69aWG2v3PmoKFCyx6b+mlnrwMF/dGEzQGfn
 WH7pKQKeTXR0ItSKLEy/LYveSlitJXeMWblifJKzzqrm10uti0u1RshXvXtY+4oh8sJD8yLC
 CzNz4TQOrx0rU+ykZwrPzkQ7L4v0LdUot2oSU7QLwjH4gvr2ezRO/JJLuyMc6RaVlEARlRHy
 B296GzgxuWIMChWM8f01z2pMXhsPxnRrBjG74NnWlNclLcjJZ/xeWsGtPl6718LLWmHmx8oT
 PWyKEeimvoslRH5Fhk809wuGBNK7HSEv2NybZ2sqdakmsOrb6BhbV//lqTnfe8/UVqUVofGu
 tZIL6FTndP0apnzkuRdkflpN8x7AHf4w5x9jJ07DALgIz+GiKDrPxCEKnn2X7a/FpNSVHclV
 PtY7llqhVclVm/L24EImdfWD9gqfyIdATrWrwdNHlFQ+Ua77h4leU85ptuyH1O5h7C4I+gRv
 eEkdExj9EIKXuuzrbFnNsMLKrNIJsTpkFtrQouFQ5oRJptDW/QARAQABzSRQYXRyaWNrIFNj
 aHVsdHogPFBhdHJpY2tAcGF0ZmFiLm5ldD7CwXkEEAEIACMCGQEFAlulcAYHCwkIBwMCAQYV
 CAIJCgsEFgIDAQIeAQIXgAAKCRCFt6PPoU8UcHw3D/42p8hHV4Tp6swUnNh2qzRB+Vi+8SAk
 vgxXmhl02qAmVGLPxJrzgGP7lz90VjJAGjOo5Zd35LecUFNRuCuZoH3QQR9CR+BNNDbkZGTm
 qpKMVEpyI0dmHuectRrc7FwAcBKagcwPjWpuIuXkJ93QnCKDVxbr8tIW+blRorxyQFIhV5mT
 xoaVTPho9IvYvw9rVsgA6mZM0aS+DOxRAU/+wXDbg/+rsOPMBW12H1+jPC/FG5Z3MtNDxVnb
 h0089FI5BdVwuPDfL3D13eSBGaPfhGVlM/lBYppzswT+2TUsdflog6oG82tUDlWo79LVfMYy
 ITfr4POMqmC7snte42GOHnH5lBj9/XkQA79K7W9wQx1cNTYye5DOAJ3wAjByF+hs/PB/FCTn
 nPmrr+LJUvYvTUqDxzjqK+e1nONDS8JEuba0ndIsLfqqx3Fo1M36dGLpxCMX0sC9zjisLHw4
 Td0PMg0mjsLHtXAngjTIIckyUyJTznsVY32nP2FXD/sb8Y/zocZFuOUSUcWwWC5Iyb2rxWkF
 0G81cwbF+C8a0Sbg6xWhTZdrIFDxX/mQFpD0PWjJ3JUlQTGEj2KG9Sq5+xPi6+w7+JXsU3f7
 d3NuvnbQB2zmZd8tILI9GQK28nUOKhVhpeLrknu+UTDeRdNgTZRr0Bx7/uOpmcXCUGTcK0gU
 dUEpDg==
Organization: PatFab-Network
Message-ID: <044c9c5b-a7a2-effa-7a07-8bea5edcb9c3@patfab.net>
Date:   Mon, 8 Jul 2019 01:21:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature";
 boundary="DdArZ6vcP47gcXOk0ByQjwdi4zcrCok4a"
X-Provags-ID: V03:K1:mQu+5T7m9kOkol8/wtKJsY7ROPCRKke5S7Ol8x6sFhkAmfL+6jW
 xOCsele8fNBDB4E2e96WplgqP0GyRBV1Dqci3qY605pcgDxO0LbN0H83lB41ks2eVx/Ukbe
 /azTAKYPAIijPh+7OZp+aQt48VUEp/oXzUjF6z+dFwcvYZDdTyZjagmhwMWkKpEPqdv+aZi
 xP+vZ7XZshqvOdU7OJ4ng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yMo5Lr7+MCE=:9LHFaulih13otW8JXwbSwA
 FSSGvOXiCxTEIbAZLSYgcmBEQOr/Fh66Abn/b3sM7M7EViGAAiF5hA3ILzWJipkKhgNVzIC7O
 jzYTRRwTdleSkoL9GoSxTBnZefiF8hmDn0WUhVGC/meYye3XdApaq4g3pD/Mm5Ac1ad/FaoFD
 NKnjOlxZof7bvr+P9uwMWMcrAmY42riGGF6Srj0EHBmXFcqCEk7t987SeMZ/aqFUCQH6wiZce
 DHbLOERDZD3LYFyQHAqvgGqzyRdttuBZeLHXUMnBFp9IPRtfYmqKpGcWKFiAPKtz2UPKyN7gf
 JmLnAv2ez1c5KqWnSktvQetK5ocNQ5pCZY4o0FJp6NFZGLZ5R6ziAi3U5/DZ1VO1hDYlZ9TOB
 /CQdZBhNqSec1VUA27rrBU+yd4xZNmS+SlCspdBKIs29EURCqMlTEhQUDsCq0yQLiWTMgAk19
 +KBPYn0WlI/oeYko3E94zHtL7hz+JQbrsbnwHYf+8HLPZA+BtOfVVtld76Kom6QAYcsyUztJm
 ycAyTlM29Gtm5u7lXXveqO/Qi0VgpIITBwpyXeCopaarHB3C79EuMNqb93rcxRGS5pjafay/X
 3fUDr5DRt2n0lOjj4GyQPsJyXK9DULGXLE/2fv7jUt7SeimyAFPDJoOMvTJli0Bjdj2IXNidi
 rAsHkaRBT63wZAy0k5AsM/O/pOrM2nmjmJ0Trv5H7quyW36ZpmJCxOOJpvX6NA2CxfZrIdCQl
 Hhou5ites7TCHNgDvsl9rgsdiB2p9Iy22edU8A==
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DdArZ6vcP47gcXOk0ByQjwdi4zcrCok4a
Content-Type: multipart/mixed; boundary="ojGYDkqbJPrjKkQJuKSCa3Hzq244q2d8B";
 protected-headers="v1"
From: Patrick Schultz <Patrick@patfab.net>
To: linux-sctp@vger.kernel.org
Message-ID: <044c9c5b-a7a2-effa-7a07-8bea5edcb9c3@patfab.net>
Subject: Support for RFC 6951 (UDP encapsulation for SCTP)

--ojGYDkqbJPrjKkQJuKSCa3Hzq244q2d8B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB

Hello all,

are there already plans to support UDP encapsulation in lksctp-tools acco=
rding to RFC6951?

Best regards,
Patrick



--ojGYDkqbJPrjKkQJuKSCa3Hzq244q2d8B--

--DdArZ6vcP47gcXOk0ByQjwdi4zcrCok4a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - https://www.enigmail.net/

iQIcBAEBCQAGBQJdIn6AAAoJEIW3o8+hTxRwf2UP/jPuUlNF+ok/KpQBTeyyKuqS
2K4rvnEaLHpE1I45OLhxOANtw3za3UadR4PMscJ7+CzfxcHsO+lAA+gjooAbSxJE
/nVxotd/8qu3H6JZp08II7iljbEGU6ZZJqjyo+Yef1VNNSv6TwX6/PsQOdKi5XOZ
1bvW/WTuLNG1DeKMgMnBWOBgg8K8blkDGBta27Q95wGKJmzgMM4rFSMQKnKIogaG
TfFuygwJB2SEol8VlTO2OJL15FIuSGrN1Xd1jR9Mf32Gcs7IgYCB7CidBrWl/bE5
AL5dt7WuAcv2raX4USosH8IZ/zj0IZIYICnMOTzqtEo1KalXlVBgWY32neasxksi
6ygtGGOGX+/jKJcKpyFvaBkdEUvpj6WmF79rFwk0udpsNj7fogBeioMIlxJdgdl8
xvgXsyxvMqetXlFZOschdLhTO6OYso3x5HRrxvIkDeINhKS+gekROMlzafmAbih/
wZvOWJ8anekX45TubSTC+pDUwwUgTUojuJI4msdEV9n0zCYscL5BJNuGe6ea2yul
sYFnEI1bWydyw3cerl1nOTs+jkJ4cxuxCT+LI7mA6CrvRQiUN20u730WXqwyqOCG
sbgIyfRYhL+PaqA15dmN0EbtBv8jIAkNYJ/wh4+5dMNMBv50JC/IcQvLw4WsSmUP
221wESMrQkUI2klxz62U
=QBEf
-----END PGP SIGNATURE-----

--DdArZ6vcP47gcXOk0ByQjwdi4zcrCok4a--
